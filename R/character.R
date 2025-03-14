#' @rdname buildAssessmentSection-methods
#' @aliases buildAssessementSection,character
setMethod("buildAssessmentSection", signature(object = "character"),
          function(object, folder, verify) {

              f_path <- file.path(object)

              if (file.exists(f_path)) {
                  doc <- xml2::read_xml(f_path)
                  if (verify) {
                      valid <- verify_qti(doc)
                      if (!valid) warning("xml file \'", object, "\' is not valid")
                  }

                  id <- xml2::xml_attr(doc, "identifier")

                  file.copy(f_path, folder)
                  message(paste("see assessment item:", file.path(folder, basename(f_path))))
                  tag("assessmentItemRef", list(identifier = id,
                                                href = basename(object)))
              }
              else {
                  warning("File or path \'", object, "\' is not correct. This ",
                          "file will be omitted in test", call. = FALSE,
                          immediate. = TRUE)
                  return(NULL)
              }
          })

#' @rdname getAssessmentItems-methods
#' @aliases getAssessmentItems,character
setMethod("getAssessmentItems", signature(object = "character"),
          function(object) {
              if (file.exists(object)) {
                  href <- basename(object)
                  doc <- xml2::read_xml(object)
                  names(href) <- xml2::xml_attr(doc, "identifier")
                  return(href)
              }
          })

# form text content of the question with html
#' @rdname createText-methods
#' @aliases createText,character
#' @importFrom htmltools HTML
setMethod("createText", "character", function(object) {
    HTML(object)
})

# deliver nothing as outcome for character objects
#' @rdname getResponse-methods
#' @aliases getResponse,character
setMethod("getResponse", "character", function(object) {
})

#' @rdname getPoints-methods
#' @aliases getPoints,character
setMethod("getPoints", signature(object = "character"),
          function(object) {
              if (!file.exists(object)) {
                  warning(paste("file", object, "does not exist"),
                          call. = FALSE)
                  return(1)
              }
              doc <- xml2::read_xml(object)
              od_tag  <- xml2::xml_find_all(doc, ".//d1:outcomeDeclaration
                                            [@identifier='MAXSCORE']")
              points <- as.numeric(xml2::xml_text(od_tag))
              if (is.na(points)) points <- 1
              return(points)
          })

#' @rdname getIdentifier-methods
#' @aliases getIdentifier,character
setMethod("getIdentifier", signature(object = "character"),
          function(object) {
              if (!file.exists(object)) {
                  warning(paste("file", object, "does not exist"),
                          call. = FALSE)
                  return(1)
              }
              doc <- xml2::read_xml(object)
              ai_tag  <- xml2::xml_find_all(doc, "//d1:assessmentItem")
              id <- xml2::xml_attr(ai_tag, "identifier")
              return(id)
          })

#' @rdname createQtiTest-methods
#' @aliases createQtiTest,character
setMethod("createQtiTest", signature(object = "character"),
          function(object, dir = getwd()) {

              file <- object
              if (length(file) > 1) {
                  stop("Only one file can be provided as input.", call. = FALSE)
              }

              if (!all(file.exists(file))) {
                  stop("The file does not exist", call. = FALSE)
              }

              ext <- file_ext(file)
              if (ext != "zip") {
                  if (ext %in% c("Rmd", "md")) file <- rmd2zip(file, path = dir)
                  if (ext == "xml") {
                      section_obj <- section(file, title = "Preview")
                      test_obj <- test4opal(content = section_obj,
                                            identifier = "Preview")
                      file <- create_qti_test(test_obj, path = dir,
                                              zip_only = TRUE)
                  }
              }
              return(file)
          })

#' @rdname createQtiTask-methods
#' @aliases createQtiTask,character
setMethod("createQtiTask", signature(object = "character"),
          function(object, dir = getwd()) {

              file <- object
              if (length(file) > 1) {
                  stop("Only one file can be provided as input.", call. = FALSE)
              }

              if (!all(file.exists(file))) {
                  stop("The file does not exist", call. = FALSE)
              }

              ext <- file_ext(file)
              if (ext != "zip") {
                  if (ext %in% c("Rmd", "md")) {
                      obj <- create_question_object(file)
                      file <- createQtiTask(obj, dir = dir, zip = TRUE)
                  }
              }
              return(file)
          })

#' @rdname getObject-methods
#' @aliases getObject,character
setMethod("getObject", signature(object = "character"),
          function(object) {
              ext <- file_ext(object)
              if (file.exists(object) & (ext %in% c("xml", "Rmd", "md"))) {
                  if (ext %in% c("Rmd", "md")) {
                      object <- create_question_object(object)
                  }
                  return(object)
              }
              return(NULL)
          })

#' @rdname getFiles-methods
#' @aliases getFiles,character
setMethod("getFiles", signature(object = "character"),
          function(object) {
              return(character(0))
          })

#' @rdname getCalculator-methods
#' @aliases getCalculator,character
setMethod("getCalculator", signature(object = "character"),
          function(object) {
              return(character(0))
          })

#' @rdname prepareQTIJSFiles-methods
#' @aliases prepareQTIJSFiles,AssessmentItem
setMethod("prepareQTIJSFiles", signature(object = "character"),
          function(object, dir) {
              if (!file.exists(object)) {
                  stop("The file does not exist", call. = FALSE)
              }
              out_path <- file.path(dir, "index.xml")
              ext <- file_ext(object)
              if (ext %in% c("Rmd", "md")) {
                  task <- create_question_object(object)
                  create_qti_task(task, out_path, verification = FALSE)
                  current_rmd_fullpath <- normalizePath(object)
                  xml_target <- sub("\\.Rmd$", ".xml", current_rmd_fullpath)
                  file.copy(out_path, xml_target)
              }
              if (ext == "xml") file.copy(object, out_path)
              if (ext == "zip") zip::unzip(object, exdir = dir)
              params <- knit_params(readLines(object))
              if (!is.null(params$preview_feedback$value)) {
                  return(params$preview_feedback$value)
              }
              return(NULL)
          })

#' @rdname getContributors-methods
#' @aliases getContributors,character
setMethod("getContributors", signature(object = "character"),
          function(object) {
              return(NULL)
          })

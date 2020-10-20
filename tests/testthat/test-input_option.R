test_that("input_option", {
  expect_error(input_option(text="Country"))
  expect_error(input_option(text = "Province"))
  expect_error(input_option(text="Summary"))
  
  test<-input_option("country",covid19_count)
  expect_length(test,3)
})

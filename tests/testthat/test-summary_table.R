test_that("multiplication works", {
  expect_error(summary_table(text=NULL))
  expect_error(summary_table(text=""))
  
  test<-summary_table("Australia")
  expect_length(test,1)
})

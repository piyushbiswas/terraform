resource "github_repository" "my-test-repo-by-terraform" {
  name        = "mt-first-terrafom-repo"
  description = "My first github repo by terraform"
  visibility = "public"

}
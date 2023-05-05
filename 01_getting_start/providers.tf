provider "aws" {
  # Configuration options
  profile = "trungadmin"
  region  = "ap-northeast-1"
}

provider "aws" {
  profile = "trungadmin"
  # Osaka
  region = "ap-northeast-3"
  alias  = "osaka"

}

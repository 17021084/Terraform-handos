provider "aws" {
  # Configuration options
  # profile = "trungadmin"
  region  = "ap-northeast-1"

}

provider "aws" {
  # profile = "trungadmin"
  # Osaka
  region = "ap-northeast-3"
  alias  = "osaka"
  
  # another way to declare
  # access_key = AWS_ACCESS_KEY_ID
  # secret_key = AWS_SECRET_ACCESS_KEY_ID

}

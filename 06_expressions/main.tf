terraform {

}

variable "hello" {
  type = string
}

variable "languages" {
  type = list(any)
}


variable "country" {
  type = map(any)
}


variable "region" {
  type = object({
    name : string,
    country : string,
    city : string,
    area : number
  })
}



variable "splat_example" {
  type = list(any)
}

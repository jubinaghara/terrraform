//==============================================================================================//
//     - "for" expression                                                                       //
//==============================================================================================//

terraform {

}


// =================== Example 1: DIRECTIVES  ==================//
# variable "hello" {
#   type = string
# }


// =================== Example 2: FOR EXPRESSION ==================//
variable "worlds" {
  type = list
}


// =================== Example 3: SPLATS ==================//
variable "worlds_map" {
  type = map
}

variable "worlds_splat" {
    type = list
}



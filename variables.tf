variable "user_uuid" {
  type        = string
  description = "The UUID of the user"
  validation {
    condition     = can(regex("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[1-5][a-fA-F0-9]{3}-[89abAB][a-fA-F0-9]{3}-[a-fA-F0-9]{12}$", var.user_uuid))
    error_message = "The user_uuid must be in UUID format (8-4-4-4-12 hexadecimal characters)."
  }
}

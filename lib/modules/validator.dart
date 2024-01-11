String? validateNonEmpty(String? value)
{
  if (value == null || value.isEmpty) {
    return 'This field must not be empty';
  }
  return null;
}
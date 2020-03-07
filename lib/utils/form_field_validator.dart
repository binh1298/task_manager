String validateFormField(String value, String fieldName, int minLength, {int maxLength = 50}) {
  if (value.isEmpty) {
    return 'Please enter user\'s $fieldName!';
  }
  if (value.length < minLength) {
    return 'Please enter $fieldName longer than $minLength characters';
  }

  if (value.length > maxLength) {
    return 'Please enter $fieldName shorter than $maxLength characters';
  }
  return null;
}

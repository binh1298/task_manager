String validateFormField(String value, String fieldName, int minLength,
    {int maxLength = 50}) {
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

String validateNumberField(dynamic value, String fieldName, int min, int max) {
  if (value != null && value != '') {
    int result;
    try {
      result = int.tryParse(value);
    } catch (e) {
      return 'Invalid $fieldName';
    }
    if (result != null) {
      if (result <= min || result >= max) return 'This is only from $min to $max';
    } else {
      return 'Invalid $fieldName';
    }
  }
  return null;
}

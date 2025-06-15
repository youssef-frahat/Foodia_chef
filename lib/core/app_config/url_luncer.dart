String sanitizeUrl(String rawUrl) {
  if (rawUrl.trim().isEmpty) return '';

  final trimmed = rawUrl.trim();
  final lowercased = trimmed.toLowerCase();
  final sanitized = Uri.encodeFull(lowercased);

  return sanitized;
}

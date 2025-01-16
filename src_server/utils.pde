// Fonction pour obtenir un timestamp avec "_"
String getTimestampWithUnderscores() {
  return year() + "_" + nf(month(), 2) + "_" + nf(day(), 2) + "_" + nf(hour(), 2) + "_" + nf(minute(), 2) + "_" + nf(second(), 2);
}

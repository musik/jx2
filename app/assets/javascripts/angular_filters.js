/**
 * Truncate Filter
 * @Param text
 * @Param length, default is 10
 * @Param end, default is "..."
 * @return string
 */
angular.module('filters', []).filter('truncate', function () {
  return function (text, length, end) {
    if (isNaN(length)) length = 10;
    if (end === undefined) end = "...";
    if (text.length <= length || text.length - end.length/3 <= length) {
      return text;
    }
    else {
      return String(text).substring(0, length-end.length) + end;
    }

  };
});

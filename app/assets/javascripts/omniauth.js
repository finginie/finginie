function auto_refresh() {
  isInIFrame = (window.location != window.parent.location) ? true : false;
  if (isInIFrame) {
    parent.location.href = window.location.href;
  }
}

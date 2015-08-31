$ ->
  unless (/Android|iPhone|iPad|iPod|BlackBerry|Windows Phone/i).test(navigator.userAgent or navigator.vendor or window.opera)
    s = skrollr.init forceHeight: false
    s.refresh()

history.scrollRestoration = "manual"

window.addEventListener(
  "wheel",
  function (e) {
    let header = this.document.querySelector(".header_nav_wrapper").offsetTop
    let top = document.querySelector(".index_content01")

    let location = document.querySelector(".index_content").offsetTop
    // 위로 스크롤
    if (e.wheelDelta >= 120 && window.scrollY <= location) {
      window.scrollTo({ top: header, behavior: "smooth" })
      top.style.zIndex = "0"
      top.style.opacity = "1"
    }

    // 아래로 스크롤
    if (e.wheelDelta <= -120 && this.window.scrollY <= 200) {
      window.scrollTo({ top: location, behavior: "smooth" })
      top.style.zIndex = "-1"
      top.style.opacity = "0.1"
    }
  },
  { passive: false }
)

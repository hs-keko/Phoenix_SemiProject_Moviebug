// 현재 페이지명
const getPageName = () => {
  let pageName = ""
  let tmpPageName = window.location.href
  let strpname = tmpPageName.split("/")
  // pageName = strpname[strpname.length - 1].split("?")[0]
  pageName = strpname[4]
  return pageName
}

// 내정보, qna 페이지에 따라 navbar 요소 none 처리
const navDisplay = (pageName) => {
  let nav_userinfo = document.querySelector(".nav_user")
  if (pageName === "users" || pageName === "cafe") {
    nav_userinfo.style.display = "none"
  }
}

// navbar 검색창, 리셋버튼, 검색폼
let sInput = document.querySelector("#nav_search_input")
let keywordResetBtn = document.querySelector(".keyword_resetBtn")
let searchform = document.querySelector("#search_form")

// 검색 기록 배열
let searchKeyword = JSON.parse(localStorage.getItem("sHistory"))

// 검색기록버튼을 담을 요소
let btnsarrtag = document.querySelector(".search_btns")

// 검색 기록 버튼 추가 함수
const createbtns = (keyword) => {
  // 검색링크 href 경로 구하기 cafe/list.jsp
  let keywordbtnanpath = ""
  let path = window.location
  keywordbtnanpath = path.origin + "/" + path.pathname.split("/")[1]

  // 검색 기록 버튼 요소
  let searchan = document.createElement("a")
  searchan.setAttribute(
    "href",
    keywordbtnanpath +
      "/searchall.jsp?condition=movie_title_direc&keyword=" +
      keyword
  )
  let searchbtns = document.createElement("button")
  searchbtns.setAttribute("class", "btn btn-light")
  searchbtns.setAttribute("type", "button")
  searchbtns.innerText = "#" + keyword

  searchan.appendChild(searchbtns)

  let cols = document.createElement("div")
  cols.setAttribute("class", "flex_box mx-3")

  cols.appendChild(searchan)

  btnsarrtag.appendChild(cols)
}

// input 의 값 체크 리셋버튼 toggle 함수
const keywordCheck = (keyword) => {
  if (keyword.length >= 0) {
    keywordResetBtn.style.display = "block"
  } else {
    keywordResetBtn.style.display = "none"
  }
}

// 검색 기록 처리 함수
const searchHistory = (keyword) => {
  if (JSON.parse(localStorage.getItem("sHistory")) != null) {
    searchKeyword = JSON.parse(localStorage.getItem("sHistory"))
  }

  // 배열이 10개이상이면 맨뒤의 값을 하나 삭제
  if (searchKeyword.length >= 10) {
    searchKeyword.pop()
  }

  let keyidx = searchKeyword.indexOf(keyword)
  // 검색기록에 검색값이 없으면 새로 추가
  if (keyidx < 0) {
    searchKeyword.unshift(keyword)
  } else {
    // 검색기록에 검색값이 있다면 해당 값을 삭제하고 맨앞에 검색값을 추가

    searchKeyword.splice(keyidx)

    searchKeyword.unshift(keyword)
  }

  console.log(searchKeyword)

  searchKeyword.forEach((arrval) => {
    createbtns(arrval)
  })

  localStorage.setItem("sHistory", JSON.stringify(searchKeyword))
}

//////////////////////////////////////////////////////////////////////////// run
// users 일때 내정보 숨김
navDisplay(getPageName())

// 검색기록이 존재하면 변수에 저장
if (searchKeyword != undefined) {
  searchKeyword = JSON.parse(localStorage.getItem("sHistory"))
  searchKeyword.forEach(function (arrval) {
    createbtns(arrval)
  })
} else {
  // 검색기록이 존재하지 않으면새로 저장
  localStorage.setItem("sHistory", JSON.stringify([]))
}

sInput.addEventListener("input", (e) => {
  let keyword = e.target.value
  keywordCheck(keyword)
})

keywordResetBtn.addEventListener("click", () => {
  sInput.value = ""
  keywordResetBtn.style.display = "none"
})

searchform.addEventListener("submit", function (e) {
  searchHistory(sInput.value)
})

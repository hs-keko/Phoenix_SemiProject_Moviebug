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
  // 검색 기록 버튼 요소
  let searchbtns = document.createElement("button")
  searchbtns.setAttribute("class", "btn btn-light")
  searchbtns.setAttribute("type", "button")
  searchbtns.innerText = keyword

  // gird col
  let cols = document.createElement("div")
  cols.setAttribute("class", "col flex_box")

  cols.appendChild(searchbtns)

  btnsarrtag.appendChild(cols)
}

// 검색기록이 존재하면 변수에 저장
if (searchKeyword != undefined) {
  searchKeyword = JSON.parse(localStorage.getItem("sHistory"))
  console.log(searchKeyword)

  searchKeyword.forEach(function (arrval) {
    createbtns(arrval)
  })
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

  let keyidx = searchKeyword.indexOf(keyword)
  // 검색기록에 검색값이 없으면 새로 추가
  if (keyidx < 0) {
    searchKeyword.unshift(keyword)
  } else {
    // 검색기록에 검색값이 있다면 해당 값을 삭제하고 맨앞에 검색값을 추가

    searchKeyword.splice(keyidx)

    searchKeyword.unshift(keyword)
  }

  // 배열이 10개이상이면 맨뒤의 값을 하나 삭제
  if (searchKeyword.length >= 10) {
    searchKeyword.pop()
  }
  console.log(searchKeyword)

  searchKeyword.forEach((arrval) => {
    createbtns(arrval)
  })

  localStorage.setItem("sHistory", JSON.stringify(searchKeyword))
}

sInput.addEventListener("input", (e) => {
  let keyword = e.target.value
  keywordCheck(keyword)
})

keywordResetBtn.addEventListener("click", () => {
  sInput.value = ""
  keywordCheck("")
})

searchform.addEventListener("submit", function (e) {
  searchHistory(sInput.value)
})

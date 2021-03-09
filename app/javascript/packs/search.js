const searchTag = document.querySelector(".search");
const searchButton = document.querySelector(".search-btn");
const inputTag = document.querySelector(".search-input");

const searchAnimation = () => {
  searchButton.addEventListener("mouseover", () => {
    searchTag.classList.add("active");
    inputTag.focus();
  });
};

export { searchAnimation };

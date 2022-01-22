import React from "react";
import "./Search.css";

const Search = () => {
  return (
    <div className="srch-hldr">
      <input className="srch-inpt" placeholder="Search Planets" />
      <div className="srch-icon-hldr">
        <img className="srch-icon" src="./images/navbar/search.svg" />
      </div>
    </div>
  );
};

export default Search;

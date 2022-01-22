import React from "react";
import "./Navbar.css";
import Search from "./Search";

const Navbar = () => {
  return (
    <header className="nav-hdr">
      <div className="nav-main">
        <div className="nav-logo-hldr">
          <div className="logo-icon-hldr">
            <img className="logo-icon" src="./images/logo.svg" />
          </div>
          <div className="logo-name-hldr">
            <p className="logo-name">Orbit721</p>
          </div>
        </div>
        <div className="nav-link-hldr">
          <ul className="nav-ul">
            <li className="nav-link">Marketplace</li>
            <li className="nav-link">Profile</li>
            <li className="nav-link">Activty</li>
            <li className="nav-link">
              <Search />
            </li>
          </ul>
        </div>
      </div>
    </header>
  );
};

export default Navbar;

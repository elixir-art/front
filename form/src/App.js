import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import NewPage from './NewPage'; // імпортуємо нову сторінку
import logo from './logo.svg';
import './App.css';

const App = () => {
  return (
    <Router>
      <div className="App">
        <nav>
          <ul>
            <li><a href="/">Головна</a></li>
            <li><a href="/new-page">Нова сторінка</a></li>
          </ul>
        </nav>
        <Routes>
          <Route path="/new-page" element={<NewPage />} />
        </Routes>
      </div>
    </Router>
  );
};

export default App;

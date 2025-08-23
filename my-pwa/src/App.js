import React from "react";
import "./App.css";
import generatedImage from "./generated-image.png"; // your image

function App() {
  return (
    <div className="App" style={{ textAlign: "center", marginTop: "50px" }}>
      <img 
        src={generatedImage} 
        alt="PWA Preview" 
        style={{ maxWidth: "80%" }} 
      />
    </div>
  );
}

export default App;


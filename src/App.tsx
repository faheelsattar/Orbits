import React, { Suspense } from "react";
import logo from "./logo.svg";
import "./App.css";
import Home from "./Pages/Home";
// import Model from "./model";
// import { Canvas } from "@react-three/fiber";
// import { OrbitControls, Stats } from "@react-three/drei";

function App() {
  return (
    <div className="App">
      {/* <>
        <Canvas style={{ height: 400, width: 800 }}>
          <pointLight position={[10, 10, 10]} />
          <ambientLight intensity={0.3} />
          <Suspense fallback={null}>
            <Model />
          </Suspense>
          <OrbitControls />
          <Stats />
        </Canvas>
      </> */}
      <Home />
    </div>
  );
}

export default App;

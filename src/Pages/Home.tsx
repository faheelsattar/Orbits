import { OrbitControls } from "@react-three/drei";
import { Canvas } from "@react-three/fiber";
import React, { Suspense } from "react";
import Navbar from "../Components/Navbar";
import Model from "../model";
import "./Home.css";
const Home = () => {
  return (
    <div
      className="home-main"
      style={{ backgroundImage: "url(/images/bg.png)" }}
    >
      <Navbar />
      <div className="home-topcover">
        <h1 className="home-tagline">
          The first <span style={{ color: "#EF5DA8" }}>3D NFT</span> planets in
          the crypto market.
        </h1>
      </div>

      <div className="planet-hldr-ftr">
        <div className="col-md-3">
          <Canvas>
            <pointLight position={[10, 10, 10]} />
            <ambientLight intensity={0.3} />
            <Suspense fallback={null}>
              <Model />
            </Suspense>
            <OrbitControls />
          </Canvas>
        </div>
        <div className="col-md-3">
          <Canvas>
            <pointLight position={[10, 10, 10]} />
            <ambientLight intensity={0.3} />
            <Suspense fallback={null}>
              <Model />
            </Suspense>
            <OrbitControls />
          </Canvas>
        </div>

        <div className="col-md-3">
          <Canvas>
            <pointLight position={[10, 10, 10]} />
            <ambientLight intensity={0.3} />
            <Suspense fallback={null}>
              <Model />
            </Suspense>
            <OrbitControls />
          </Canvas>
        </div>

        <div className="col-md-3">
          <Canvas>
            <pointLight position={[10, 10, 10]} />
            <ambientLight intensity={0.3} />
            <Suspense fallback={null}>
              <Model />
            </Suspense>
            <OrbitControls />
          </Canvas>
        </div>
      </div>
    </div>
  );
};

export default Home;

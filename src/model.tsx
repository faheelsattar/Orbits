import { useGLTF } from "@react-three/drei";
const Model: React.FC = (props: any) => {
  const { scene } = useGLTF(
    "https://orbit721.s3.ap-northeast-1.amazonaws.com/Island+Planet.gltf"
  );
  console.log("scene", scene);
  return <primitive is="x3d" object={scene} {...props} />;
};

export default Model;

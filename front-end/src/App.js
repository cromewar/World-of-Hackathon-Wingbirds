
// import './App.css';

import { HeroSection } from 'components/hero/BackgroundAsImage'
import AnimationRevealPage from "helpers/AnimationRevealPage"
import { GameFrame } from 'components/game/GameFrame';

function App() {
  return (
    <div className="App">
      {/* <AnimationRevealPage> */}
        <HeroSection />
      {/* </AnimationRevealPage> */}
      {/* <AnimationRevealPage> */}
        <GameFrame/>
      {/* </AnimationRevealPage> */}

    </div>
  );
}

export default App;

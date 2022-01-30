
// import './App.css';

import { HeroSection } from 'components/hero/BackgroundAsImage'
import AnimationRevealPage from "helpers/AnimationRevealPage"

function App() {
  return (
    <div className="App">
      <AnimationRevealPage>
        <HeroSection />
      </AnimationRevealPage>

    </div>
  );
}

export default App;

/* A simple iframe wrapper that makes 16:9 responsive embed */
import React from 'react';

// export default ({ url, background="black", className="video" }) => {
export const GameFrame = () => {
  let url = 'https://ipfs.io/ipfs/QmQJEVQQtCDdCntEDQadeypZfkwngRusN7TXDRiUPmwU1G'

  return (
    <div
      //   className={className}
      style={{
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
        //   marginTop: '-600px',
        zIndex: 100,
        background: 'black',
        //     position: "relative",
        //     background: background,
        //     paddingBottom: "56.25%" /* 16:9 */,
        //     paddingTop: 25,
        //     height: 0
      }}
    >
      <iframe
        title="Embeded Video"
        style={{
          //   position: "absolute",
          //   top: 0,
          //   left: 0,
          width: "900px",
          height: "700px"
        }}
        src={url}
        frameBorder="0"
      />
    </div>
  );
};

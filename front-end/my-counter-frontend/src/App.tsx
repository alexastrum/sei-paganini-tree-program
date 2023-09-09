import { SeiWalletProvider } from "@sei-js/react";
import "./App.css";
import Home from "./Home.tsx";

function App() {
  return (
    // <SeiWalletProvider
    //   chainConfiguration={{
    //     chainId: "sei-chain",
    //     restUrl: "http://localhost:1317",
    //     rpcUrl: "http://localhost:26657",
    //   }}
    //   wallets={["compass", "fin"]}
    // >

    // Set up SeiWalletProvider for easy wallet connection and to use hooks in @sei-js/react
    <SeiWalletProvider
      chainConfiguration={{
        chainId: "atlantic-2",
        restUrl: "https://rest.atlantic-2.seinetwork.io",
        rpcUrl: "https://rpc.atlantic-2.seinetwork.io",
      }}
      wallets={["compass", "fin"]}
    >
      <Home />
    </SeiWalletProvider>
  );
}

export default App;

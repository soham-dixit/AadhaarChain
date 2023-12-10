// import { useEffect } from "react";
// import { AnonAadhaarProvider, useAnonAadhaar, LogInWithAnonAadhaar, AnonAadhaarProof } from "anon-aadhaar-react";

// const app_id="557052232335049516014482965529112482384963436544"

// // const app_id = process.env.NEXT_PUBLIC_APP_ID;

// function Signature() {

//   const [anonAadhaar] = useAnonAadhaar();

//   useEffect(() => {
//     console.log("anonAadhaar", anonAadhaar.status);
//     if (anonAadhaar.status === "logged-in") {
//       console.log("anonAadhaar", anonAadhaar);
//       console.log("anonAadhaar.pcd.proof", anonAadhaar.pcd.proof);
//     }
//   }, [anonAadhaar]);

//   return (
//     <div>
//       <AnonAadhaarProvider _appId={app_id}  _testing={true} _isWeb={false}>
//       <div>
//         <LogInWithAnonAadhaar />
//         <p>{anonAadhaar?.status}</p>
//       </div>
//       <div >
//         {/* Render the proof if generated and valid */}
//         {anonAadhaar?.status === "logged-in" && (
//           <>
//             <p>✅ Proof is valid</p>
//             <AnonAadhaarProof code={JSON.stringify(anonAadhaar.pcd.proof, null, 2)} />
//             {
//               console.log("anonAadhaar.pcd.proof", anonAadhaar.pcd.proof)
//             }
//           </>
//         )
//         }
//       </div>
//     </AnonAadhaarProvider>
//     </div>
//   );
// }

// export default Signature;

import { useEffect } from "react";
import {
  AnonAadhaarProvider,
  useAnonAadhaar,
  LogInWithAnonAadhaar,
  AnonAadhaarProof,
} from "anon-aadhaar-react";

const app_id = "557052232335049516014482965529112482384963436544";

function Signature() {
  const [anonAadhaar] = useAnonAadhaar();

  useEffect(() => {
    console.log("anonAadhaar", anonAadhaar.status);
    if (anonAadhaar.status === "logged-in") {
      console.log("anonAadhaar", anonAadhaar);
      console.log("anonAadhaar.pcd.proof", anonAadhaar.pcd.proof);
    }
  }, [anonAadhaar]);

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-purple-600 to-pink-500">
      <div className="bg-white p-8 rounded-lg shadow-xl border-2 border-purple-700 transform transition-transform duration-300 hover:scale-105">
        <AnonAadhaarProvider
          _appId={app_id}
          _testing={true}
          _isWeb={false}
        >
          <div className="mb-6">
            <LogInWithAnonAadhaar />
          </div>
          <p className="text-2xl font-bold text-gray-800">
            {anonAadhaar?.status}
          </p>
          {anonAadhaar?.status === "logged-in" && (
            <div className="mt-4 bg-green-200 p-4 rounded-lg">
              <p className="text-green-700 text-lg">✅ Proof is valid</p>
              <AnonAadhaarProof
                code={JSON.stringify(anonAadhaar.pcd.proof, null, 2)}
              />
              {console.log("anonAadhaar.pcd.proof", anonAadhaar.pcd.proof)}
            </div>
          )}
        </AnonAadhaarProvider>
      </div>
    </div>
  );
}

export default Signature;

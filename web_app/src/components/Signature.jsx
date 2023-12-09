
import React, { useState } from 'react';
import { extractSignature } from '../utils/generateSig';
import { LogInWithAnonAadhaar } from 'anon-aadhaar-react';

const Signature = () => {
    const [isSignatureValid, setIsSignatureValid] = useState(null);
    const [pdfStatus, setpdfStatus] = useState('');
    const [signature, setsignature] = useState('');
    const [signatureValidity, setsignatureValidity] = useState('');

    const handleFileUpload = (e) => {
        pdfUpload(e);
    };

    const pdfUpload = (e) => {
        if (e.target.files) {
            try {
                const fileReader = new FileReader();
                fileReader.readAsBinaryString(e.target.files[0]);
                fileReader.onload = (e) => {
                    if (e.target) {
                        try {
                            const { signedData, signature, ByteRange } = extractSignature(
                                Buffer.from(e.target.result, 'binary')
                            );
                            console.log('Signature: ', signature);
                            if (signature !== '') {
                                setsignature(window.forge.asn1.fromDer(signature).value);
                                setsignedPdfData(signedData);
                                setpdfStatus('Signature looks valid ✅');
                                setIsSignatureValid(true);
                                setdisabledCertificateUploadInput(true);
                            }
                            else {
                                setpdfStatus('Signature looks invalid ❌');
                            }
                        } catch (error) {
                            setpdfStatus('An error occurred when verifying signature ❌');
                        }
                    }
                };
            }
            catch {
                setpdfStatus('');
                setsignatureValidity('');
            }
        }
    };

    return (
        // <div className="min-h-screen flex items-center justify-center bg-gradient-to-r from-purple-500 via-pink-500 to-red-500">
        //     <div className="bg-white p-8 rounded-lg shadow-lg max-w-md w-full relative">
        //         <h1 className="text-3xl font-bold mb-4 text-center"> 🔐 AadharChain </h1>
        //         <input
        //             type="file"
        //             accept=".pdf"
        //             onChange={handleFileUpload}
        //             className="mb-4 p-2 border border-gray-300 w-full rounded-md bg-gray-100"
        //         />
        //         {/* <LogInWithAnonAadhaar /> */}
        //         <div className="glass-effect p-4 bg-opacity-20 backdrop-blur-md backdrop-filter absolute inset-0 rounded-md pointer-events-none">
        //             {isSignatureValid === null ? (
        //                 <p className="text-gray-600 text-center">Upload a PDF to check for a signature.</p>
        //             ) : isSignatureValid ? (
        //                 <div className="text-green-500 text-center">
        //                     <p className="font-bold mb-2">🎉 Signature detected!</p>
        //                     <p className="text-xs">Your document contains a valid signature. 🚀</p>
        //                 </div>
        //             ) : (
        //                 <div className="text-red-500 text-center">
        //                     <p className="font-bold mb-2">❌ Signature not detected in document</p>
        //                     <p className="text-xs">Make sure the PDF contains a valid signature.</p>
        //                 </div>
        //             )}
        //         </div>
        //     </div>
        // </div>
        <div className="min-h-screen flex items-center justify-center bg-gradient-to-r from-purple-800 via-pink-700 to-red-600">
            <div className="bg-white p-8 rounded-lg shadow-lg max-w-md w-full relative overflow-hidden backdrop-filter backdrop-blur-md bg-opacity-80 border border-gray-300">
                <div className="glass-effect absolute inset-0 bg-gradient-to-r from-purple-800 via-pink-700 to-red-600 backdrop-filter backdrop-blur-md bg-opacity-70"></div>
                <h1 className="text-3xl font-bold mb-4 text-center text-white relative z-10 mt-10">🔐 AadharChain</h1>
                <input
                    type="file"
                    accept=".pdf"
                    onChange={handleFileUpload}
                    className="mb-4 p-3 border border-gray-300 w-full rounded-md bg-gray-100 focus:outline-none focus:ring focus:border-blue-300 z-10 transition duration-300 ease-in-out transform hover:scale-105"
                />
                <div className="glass-effect p-4 absolute inset-0 rounded-md pointer-events-none z-10">
                    {isSignatureValid === null ? (
                        <p className="text-gray-300 text-center mb-10">Upload a PDF to check for a signature.</p>
                    ) : isSignatureValid ? (
                        <div className="text-green-300 text-center">
                            <p className="font-bold mb-2 animate-bounce">🎉 Signature detected!</p>
                            <p className="text-xs">Your document contains a valid signature. 🚀</p>
                        </div>
                    ) : (
                        <div className="text-red-300 text-center">
                            <p className="font-bold mb-2 animate-shake">❌ Signature not detected in document</p>
                            <p className="text-xs">Make sure the PDF contains a valid signature.</p>
                        </div>
                    )}
                </div>
            </div>
        </div>


    );
};

export default Signature;

import React, { useState } from"react";

const NewPage = () => {
  const [step, setStep] = useState(1);

  const handleNextStep = () => {
    setStep((prevStep) => prevStep + 1);
  };
  const handlePreviousStep = () => {
    setStep((prevStep) => prevStep - 1);
  };

  return (
    <div>
      <div className="flex justify-center items-center min-h-screen dm-sans p-6 pt-0 text-neutral_800">
        <div className="bg-white rounded-md p-8">
          <h2 className="text-4xl font-bold text-center mb-3">
            Get a project quote
          </h2>
          <p className="text-xl text-neutral_600 text-center mb-11">
            Please fill the form below to receive a quote for your project.{""}
            <br />
            Feel free to add as much detail as needed.
          </p>
          <div className="border border-neutral_300 rounded-2xl shadow-md  px-11 pb-20">
            <div className="flex justify-center pt-8">
              <div className="divide-y">
                <div>01</div>
                <div>02</div>
              </div>
              {[1, 2, 3, 4].map((s) => (
                <div key={s} className="flex items-center">
                  <div
                    className={`w-9 h-9 mx-4 mb-8 flex items-center justify-center ${
                      step >= s ?"bg-primary_blue" :"bg-neutral_300"
                    } text-white rounded-full`}
                  >
                    {s}
                  </div>
                  {s !== 4 && s !== step && (
                    <div
                      className={`w-24 h-2 mb-8 rounded-full ${
                        step >= s ?"bg-primary_blue" :"bg-neutral_300"
                      }`}
                    ></div>
                  )}
                  {s !== 4 && step === s && (
                    <>
                      <div className="w-12 h-2 mb-8 rounded-full bg-primary_blue"></div>
                      <div className="w-12 h-2 mb-8 rounded-r-full bg-neutral_300"></div>
                    </>
                  )}
                </div>
              ))}
            </div>
            {step === 1 && (
              <>
                <div className="pt-16">
                  <h3 className="flex item-start text-xl font-bold mb-2">
                    Contact details
                  </h3>
                  <p className="flex item-start text-neutral_600 mb-10">
                    Please fill your information so we can get in touch with
                    you.
                  </p>
                </div>
                <div>
                  <form>
                    <div className="grid grid-cols-2 gap-4">
                      <div>
                        <label className="flex item-start pb-5">Name</label>
                        <div className="flex items-center border border-neutral_300  rounded-full p-5">
                          <input
                            type="text"
                            placeholder="John Carter"
                            className="w-full focus:outline-none"
                          />
                          <span className="ml-2  text-neutral_600"></span>
                        </div>
                      </div>
                      <div>
                        <label className="flex item-start pb-5">Email</label>
                        <div className="flex items-center border border-neutral_300 rounded-full p-5">
                          <input
                            type="email"
                            placeholder="Email address"
                            className="w-full focus:outline-none"
                          />
                          <span className="ml-2  text-neutral_600"></span>
                        </div>
                      </div>
                      <div>
                        <label className="flex item-start pb-5 pt-11">
                          Phone Number
                        </label>
                        <div className="flex items-center border border-neutral_300 rounded-full p-5">
                          <input
                            type="tel"
                            placeholder="(123) 456 - 7890"
                            className="w-full focus:outline-none"
                          />
                          <span className="ml-2  text-neutral_600"></span>
                        </div>
                      </div>
                      <div>
                        <label className="flex item-start pb-5 pt-11">
                          Company
                        </label>
                        <div className="flex items-center border border-neutral_300 rounded-full p-5">
                          <input
                            type="text"
                            placeholder="Company name"
                            className="w-full focus:outline-none"
                          />
                          <span className="ml-2  text-neutral_600"></span>
                        </div>
                      </div>
                    </div>
                  </form>
                </div>
              </>
            )}

            {step === 2 && (
              <div>
                <div className="pt-16">
                  <h3 className="flex item-start text-xl font-bold mb-2">
                    Our services
                  </h3>
                  <p className="flex item-start text-neutral_600 mb-10">
                    Please select which service you are interested in.
                  </p>
                </div>

                <div className="grid grid-cols-2 gap-6">
                  <div className="rounded-xl shadow-md border border-neutral_300">
                    <p className="p-11">Development</p>
                  </div>
                  <div className="rounded-xl shadow-md border border-neutral_300">
                    <p className="p-11">Web Design</p>
                  </div>
                  <div className="rounded-xl shadow-md border border-neutral_300">
                    <p className="p-11">Other</p>
                  </div>
                  <div className="rounded-xl shadow-md border border-neutral_300">
                    <p className="p-11">Marketing</p>
                  </div>
                </div>
              </div>
            )}

            {step === 3 && <div></div>}

            {step === 4 && <div></div>}
          </div>
          <div className="flex">
            {step < 4 && (
              <div className="flex justify-start mt-6">
                <button
                  className="bg-primary_blue text-white rounded-full text-lg h-[60px] w-[164px]"
                  onClick={handleNextStep}
                >
                  Next step
                </button>
              </div>
            )}
            {step > 1 && (
              <div className="flex justify-end mt-6">
                <button
                  type="button"
                  className=" text-primary_blue border border-primary_blue text-white py-3 rounded-full text-lg h-[60px] w-[164px]"
                  onClick={handlePreviousStep}
                >
                  Previous step
                </button>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default NewPage;

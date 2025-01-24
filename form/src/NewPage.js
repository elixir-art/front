import React, { useState } from "react";

const NewPage = () => {
  // const [selectedServices, setSelectedServices] = useState([]);

  const services = [
    { value: "development", label: "Development", icon: "\u{1F4BB}" },
    { value: "web_design", label: "Web Design", icon: "\u{1F4BB}" },
    { value: "marketing", label: "Marketing", icon: "\u{1F4E3}" },
    { value: "other", label: "Other", icon: "\u{2699}" },
  ];
  const [step, setStep] = useState(1);
  const [submit, setSubmit] = useState(false);

  const handleNextStep = () => {
    setStep((prevStep) => prevStep + 1);
  };
  const handlePreviousStep = () => {
    setStep((prevStep) => prevStep - 1);
  };
  const handleSubmit = () => {
    setSubmit((prevSubmit) => !prevSubmit);
  };

  // const setValues = (e) => {
  //   console.log(e.target);
  //   // setSelectedServices((prevState) => prevState - 1);
  // };

  const formButton =
    "p-11 rounded-xl shadow-md border border-neutral_300 peer-checked:border-primary_blue peer-checked:border-2";
  const h3 = "flex item-start text-xl font-bold mb-2";

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
              <div className="divide-y flex flex-col">
                <div className="flex flex-row">
                  {[1, 2, 3, 4].map((s) => (
                    <div key={s} className="flex items-center">
                      <div
                        className={`w-9 h-9 mx-4 mb-8 flex items-center justify-center ${
                          step >= s ? "bg-primary_blue" : "bg-neutral_300"
                        } text-white rounded-full`}
                      >
                        {s}
                      </div>
                      {s !== 4 && s !== step && (
                        <div
                          className={`w-24 h-2 mb-8 rounded-full ${
                            step >= s ? "bg-primary_blue" : "bg-neutral_300"
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
                <div></div>
              </div>
            </div>

            {step === 1 && (
              <>
                <div className="pt-16">
                  <h3 className={h3}>Contact details</h3>
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
                  <h3 className={h3}>Our services</h3>
                  <p className="flex item-start text-neutral_600 mb-10">
                    Please select which service you are interested in.
                  </p>
                </div>

                <div>
                  <form className="grid grid-cols-2 gap-6">
                    {services.map((service) => (
                      <label>
                        <input type="checkbox" className="sr-only peer" />
                        <div className={formButton}>{service.label}</div>
                      </label>
                    ))}
                  </form>
                </div>
              </div>
            )}

            {step === 3 && (
              <div>
                <div className="pt-16">
                  <h3 className={h3}>Our services</h3>
                  <p className="flex item-start text-neutral_600 mb-10">
                    Please select which service you are interested in.
                  </p>
                </div>
                <div>
                  <form className="grid grid-cols-2 gap-6">
                    {services.map((service) => (
                      <label>
                        <input type="checkbox" className="sr-only peer" />

                        <div className={`${formButton} flex items-center`}>
                          <div className="flex flex-row w-6 h-6 rounded-full border border-neutral_300 peer-checked:bg-primary_blue mr-3"></div>
                          <p className="">$5.000 - $10.000</p>
                        </div>
                      </label>
                    ))}
                  </form>
                </div>
              </div>
            )}

            {step === 4 && (
              <div>
                <button
                  className="bg-primary_blue text-white mt-10 rounded-full text-lg h-[60px] w-[164px]"
                  onClick={handleSubmit}
                >
                  Submit
                </button>
              </div>
            )}
          </div>
          <div className="flex justify-between mt-6">
            {step > 1 && (
              <button
                type="button"
                className="text-primary_blue border border-primary_blue py-3 rounded-full text-lg h-[60px] w-[164px]"
                onClick={handlePreviousStep}
              >
                Previous step
              </button>
            )}
            {step < 4 && (
              <button
                className="bg-primary_blue text-white rounded-full text-lg h-[60px] w-[164px]"
                onClick={handleNextStep}
              >
                Next step
              </button>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default NewPage;

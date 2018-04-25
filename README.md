# temperature-sensitive-sir

## Synopsis
This is the implementation of the seasonality/temperature-sensitive SEI-SEIR model for arbovirus transmission to be used by the Mordecai lab. The model is a standard compartmental and mechanistic framework that divides the mosquito population into three compartments (susceptible, exposed, and infected) and the human population into four compartments (susceptible, exposed, infected, and recovered). Here, the thermal response functions for the Aedes aegypti mosquito provided by [Mordecai et al. (2016)](http://biorxiv.org/content/biorxiv/early/2016/07/15/063735.full.pdf) are incorporated. Temperature is modeled as a sinusoidal curve with varying mean temperature and amplitude. 

## Installing
1. Clone or download this repository.

  ``` 
  git clone https://github.com/jhuber3/temperature-sensitive-sir.git
  ```
  
2. Ensure that cmake is installed by checking `which cmake`. If it is not, install it. 
3. Ensure that the g++ compiler is intalled by checking `which gcc`. To run the model, you should have gcc 4.9.2. To confirm that the proper version is installed, run `gcc --version`. If it is not, install it.

## Building

Enter into the EpidemicIndices_StartTemp/ or FinalEpidemicSize/ folders. If you have done the above, you are set to compile the code. Check to see that you are in the home directory by running `pwd`. Then, do the following:
```
cd build
cmake ..
make 
```
This will build and compile the code, and an executable `simulations` will be generated in the home directory. 

## Running the model
1. To run the model, you must create an output directory. 

  ```
  mkdir output
  ```
2. Next, run the script `script.sh` by `qsub script.sh`. This shell script runs the model in parallel on a cluster. For faster simulations, I recommend running the code on your institution's high performance cluster. The script will generate .txt files of the form `output_<mean temperature>.txt` where `<mean temperature>` is the mean temperature of the sinusoidal temperature curve. Each element in the .txt file corresponds to the final epidemic size of a simulation with a given mean temperature (specified by the file name) and an amplitude. The range of amplitudes can be found in model.cpp.
3. Once the simulations are complete, `rm testarray*` in the home directory. 
4. Alternatively, if you do not wish to simulate on a cluster, you can run `./simulations`.
5. If the model ran appropriately, change to the output directory `cd output` and verify that there are .txt files there using `ls`

## License 
All code contained within this repository is released under the [CRAPL v0.1 License](http://matt.might.net/articles/crapl/).

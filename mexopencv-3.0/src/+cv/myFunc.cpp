#include "mexopencv.hpp"
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    // Check arguments
    nargchk (nlhs<=1 && nrhs==1);

    // Convert MxArray to cv::Mat
    cv::Mat mat = MxArray(prhs[0]).toMat();

    // Do whatever you want

    // Convert cv::Mat back to mxArray*
    plhs[0] = MxArray(mat);
}
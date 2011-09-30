
def get_peaks(self): # MSSpectrum[Peak1D] spec_):

    cdef _MSSpectrum[_Peak1D] * spec_ = self.inst

    cdef unsigned int n = spec_.size()
    cdef np.ndarray[np.float32_t, ndim=2] peaks 
    peaks = np.zeros( [n,2], dtype=np.float32)
    cdef _Peak1D p
    for i in range(n):
        p = deref(spec_)[i]
        peaks[i,0] = p.getMZ()
        peaks[i,1] = p.getIntensity()
    return peaks

def set_peaks(self, np.ndarray[np.float32_t, ndim=2] peaks):
        
    cdef _MSSpectrum[_Peak1D] * spec_ = self.inst

    #cdef int delete_meta = 0
    spec_.clear(0) # delete_meta) # emtpy vector , keep meta data
    cdef _Peak1D p = _Peak1D()
    cdef float mz, I
    cdef int N
    N = peaks.shape[0]
    for i in range(N):
        mz = peaks[i,0]
        I  = peaks[i,1]
        p.setMZ(mz)
        p.setIntensity(I)
        spec_.push_back(p)

    spec_.updateRanges()


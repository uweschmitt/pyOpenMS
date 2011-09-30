
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


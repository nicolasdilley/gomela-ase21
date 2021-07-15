package main

func collectFileInfoForChanges(oldDir, newDir string) (*FileInfo, *FileInfo, error) {
	var (
		oldRoot, newRoot *FileInfo
		err1, err2       error
		errs             = make(chan error, 2)
	)
	go func() {
		oldRoot, err1 = collectFileInfo(oldDir)
		errs <- err1
	}()
	go func() {
		newRoot, err2 = collectFileInfo(newDir)
		errs <- err2
	}()

	// block until both routines have returned
	for i := 0; i < 2; i++ {
		if err := <-errs; err != nil {
			return nil, nil, err
		}
	}

	return oldRoot, newRoot, nil
}

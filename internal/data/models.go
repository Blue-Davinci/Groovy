package data

import (
	"database/sql"
	"errors"
)

// Define a custom ErrRecordNotFound error. We'll return this from our Get() method when
// looking up a movie/users/tokken that doesn't exist in our database.
var (
	ErrRecordNotFound = errors.New("movie record not found")
	ErrEditConflict   = errors.New("edit conflict")
)

// Create a Models struct which wraps the Movie & User Model.
type Models struct {
	Movies      MovieModel
	Permissions PermissionModel
	Users       UserModel
	Tokens      TokenModel
}

// For ease of use, we also add a New() method which returns a Models struct containing
// the initialized Movie & User Model.
func NewModels(db *sql.DB) Models {
	return Models{
		Movies:      MovieModel{DB: db},
		Permissions: PermissionModel{DB: db},
		Users:       UserModel{DB: db},
		Tokens:      TokenModel{DB: db},
	}
}

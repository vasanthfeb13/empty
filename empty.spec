Name:           empty
Version:        1.0
Release:        1%{?dist}
Summary:        Lightning-fast utility to empty files and directories

License:        MIT
URL:            https://github.com/vasanthfeb13/empty
Source0:        %{name}-%{version}.tar.gz

BuildArch:      noarch
Requires:       bash

%description
A powerful command-line utility that provides a convenient way to:
- Empty the contents of a file without deleting the file itself
- Clear all contents within a directory while preserving the directory structure
- Maintain file and directory attributes while emptying contents
- Provide clear feedback for all operations

%prep
%setup -q

%install
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_mandir}/man1
install -p -m 755 empty %{buildroot}%{_bindir}/empty
install -p -m 644 empty.1 %{buildroot}%{_mandir}/man1/empty.1

%files
%license LICENSE
%doc README.md
%{_bindir}/empty
%{_mandir}/man1/empty.1*

%changelog
* Thu Jan 04 2025 M.Vasanthadithya <vasanth.mundrathi@gmail.com> - 1.0-1
- Initial package release
- Added support for emptying both files and directories
- Included man page documentation
- Added safety checks for file/directory existence
- Improved error handling and user feedback

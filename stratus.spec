Name            : stratus
Summary         : stratus application
Version         : 0.0.1
Release         : 0.1

Group           : Applications/File
License         : (c)Sabre

BuildArch       : noarch
BuildRoot       : %{_tmppath}/%{name}-%{version}-root


# Use "Requires" for any dependencies, for example:
# Requires        : tomcat6

# Description gives information about the rpm package. This can be expanded up to multiple lines.
%description
stratus app


# Prep is used to set up the environment for building the rpm package
# Expansion of source tar balls are done in this section
%prep

# Used to compile and to build the source
%build

# The installation.
# We actually just put all our install files into a directory structure that mimics a server directory structure here
%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/opt/railsapps/
install -d -m 755 $RPM_BUILD_ROOT/opt/railsapps/
cp -R ../SOURCES/stratus/ $RPM_BUILD_ROOT/opt/railsapps/.
#tar xvfz $RPM_BUILD_ROOT/opt/railsapps/stratus.tar.gz -C /opt/railsapps/

# Contains a list of the files that are part of the package
# See useful directives such as attr here: http://www.rpm.org/max-rpm-snapshot/s1-rpm-specref-files-list-directives.html
%files
%attr(755, root, -) 
#FILESMARKER

# Used to store any changes between versions
%changelog

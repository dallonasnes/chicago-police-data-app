# Chicago Police Data app

A prototype app to identify active Chicago police officers with a history of misconduct and easily compose data-driven emails to elected reps advocating for citizen oversight of the police.

The app fetches publicly available data on active Chicago police officers from a remote endpoint (see `dallonasnes/police-data-gatherer`). Each officer listed is displayed on screen, and clicking an officer's name lets user see details of misconduct, complaints, promotions, etc. It also exposes a button to email your elected reps with a template that includes emphasizes data on troublesome officers and advocates for CPAC.

Note that this app is a prototype. Future TODOs before launch include:
1. Implement a more-thoughtful UI design
1. Add required legal notices for data from misconduct lawsuits
1. Better project naming + images (current ones were are meant for a laugh during dev but not to be used in production)


## To build
1. Clone this repo
1. Open in XCode -> Run on emulator

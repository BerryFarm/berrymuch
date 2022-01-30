
Kaloudov, [30 Jan 2022 at 16:46:43]:
Someone is working on tslib for bb10 .. Any success ?

Hero in, [30 Jan 2022 at 16:58:51 (30 Jan 2022 at 16:59:07)]:
Well, the library has been built but requires some manual patching of cmake config files.
I'll patch them and upload patched sources and prebuilt libs somewhere once I get better (cursed corona)

Kaloudov, [30 Jan 2022 at 16:59:26]:
May I ask you to prepare a patch for inclusion in berrymuch/ ?

I mean a PR ?

Oh sorry about Corona

Braulio Solano Rojas, [30 Jan 2022 at 17:00:16]:
I wish a good recovery.  I had the same problem two weeks ago but I am fine now.

Hero in, [30 Jan 2022 at 17:11:03]:
Yes. But keep in mind that the process of building this library is really painful. You have to:
1) Compile on host machine to generate some headers
2) Split some notoriously big source files to avoid out of memory crashes
3) Patch split files (you can't do it prematurely because they won't split)
4) Build. It'll take ~1hour to build single configuration on a desktop PC with 4 parallel jobs and 16gb of ram.


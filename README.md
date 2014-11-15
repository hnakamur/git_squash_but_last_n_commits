git_squash_but_last_n_commits
=============================

a bash script to squash git commits before last n commits and remove unused files from .git

## Setup

```
chmod +x git_squash_but_last_n_commits.sh
```

And put `git_squash_but_last_n_commits.sh` to some directory in the PATH 

## Example

### before squash

```
% git log
commit d08f035be73e38cfe20fdf492302ca0dab659f90
Author: Hiroaki Nakamura <hnakamur@gmail.com>
Date:   Sat Nov 15 21:10:49 2014

    Add hello6

commit 8424ea78bf5a9a5634b6a647b2088ff255ce452f
Author: Hiroaki Nakamura <hnakamur@gmail.com>
Date:   Sat Nov 15 21:10:48 2014

    Add hello5

commit aaa014a51dc1c4bcdc6ba82327eb12d230384c6a
Author: Hiroaki Nakamura <hnakamur@gmail.com>
Date:   Sat Nov 15 21:10:43 2014

    Add hello4

commit 2027c22669fb02734c4ae5e20a02d3823a393878
Author: Hiroaki Nakamura <hnakamur@gmail.com>
Date:   Sat Nov 15 21:10:43 2014

    Add hello3

commit cc4acfd45dfdc96cfc77cb063f7dde27f954bb6e
Author: Hiroaki Nakamura <hnakamur@gmail.com>
Date:   Sat Nov 15 21:10:42 2014

    Add hello2

commit 648a7d26a6bdb18cc795824499e8abd4e7e8e28b
Author: Hiroaki Nakamura <hnakamur@gmail.com>
Date:   Sat Nov 15 21:10:30 2014

    Initial commit
```

### squash

Specify the count of commits to keep as the argument.

```
% git_squash_but_last_n_commits.sh 2
```

### after squash

```
% git log
commit 752513b0c510bd69d143d91778936b74721ce6a2
Author: Hiroaki Nakamura <hnakamur@gmail.com>
Date:   Sat Nov 15 21:10:49 2014

    Add hello6

commit 3b0f962b9b10ecbab97db37e34c89b3e9ea0b892
Author: Hiroaki Nakamura <hnakamur@gmail.com>
Date:   Sat Nov 15 21:10:48 2014

    Add hello5

commit 504c12abe51fdc6b1fa38c7bce985c2449661957
Author: Hiroaki Nakamura <hnakamur@gmail.com>
Date:   Sat Nov 15 21:10:42 2014

    Add hello2

    Add hello3

    Add hello4

commit 648a7d26a6bdb18cc795824499e8abd4e7e8e28b
Author: Hiroaki Nakamura <hnakamur@gmail.com>
Date:   Sat Nov 15 21:10:30 2014

    Initial commit
```

## Caveats

The first commit will not be squashed like the above example.

Actually you can squash the first commit using newer version of git like 2.1.3
https://github.com/hnakamur/git_squash_but_last_n_commits/blob/105791973cd5e969563304a4518e7a1dbfc89a2e/git_squash_but_last_n_commits.sh#L12

However old version of git like 1.7.1 on CentOS 6.6 prints the error `You must specify --onto when using --root` for `git rebase -i --root`.

After all, I came to think I will keep the first commit because the date of the first commit is important and I would like to see it after squash.

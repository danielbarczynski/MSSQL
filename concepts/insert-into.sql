-- normal insert into
insert into Persons2
values
    (4, 'Miki', 70, 3),
    (5, 'Aki', 30, 3)

-- insert into with identity
insert into Hobbies
values
    ('Piano'),
    ('Reading'),
    ('Gym')

-- insert into column (must be at least Id column) --! bad practice - use update
insert into Persons2
    (Id, HobbyId)
values
    (1, 1),
    (2, 2),
    (3, 2)
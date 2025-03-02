create table
  public.profiles (
    id bigint generated by default as identity not null,
    user_id uuid not null default auth.uid (),
    created_at timestamp with time zone not null default now(),
    first_name character varying not null,
    last_name character varying not null,
    patronymic character varying null,
    gender character varying null,
    birth_date date not null,
    grade smallint not null,
    old_school character varying not null,
    parent_first_name character varying not null,
    parent_last_name character varying not null,
    parent_patronymic character varying null,
    june_exam boolean not null default false,
    vmsh boolean not null default false,
    source text not null,
    approved boolean not null default false,
    parent_phone character varying not null,
    avatar character varying not null,
    constraint profiles_pkey primary key (id),
    constraint profiles_user_id_first_name_grade_key unique (user_id, first_name, grade),
    constraint profiles_user_id_fkey foreign key (user_id) references auth.users (id) on update cascade on delete cascade,
    constraint valid_gender check (
      (
        (
          (gender)::text = any (
            array[
              ('M'::character varying)::text,
              ('F'::character varying)::text
            ]
          )
        )
        or (gender is null)
      )
    ),
    constraint valid_birth_date check (
      (
        (
          birth_date >= (current_date - '18 years'::interval)
        )
        and (
          birth_date <= (current_date - '9 years'::interval)
        )
      )
    ),
    constraint valid_grade check (
      (
        (grade >= 6)
        and (grade <= 11)
      )
    )
  ) tablespace pg_default;

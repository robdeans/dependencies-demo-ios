DependenciesDemo
============

## Goals
To observe variations between:
1. Dependencies nested within one another
2. Dependencies that are constructed using class vs struct
3. The effects of placement when declaring such Dependencies

## App Structure
`MarvelHeroesService` - the API service that will fetch data (or return errors)
`HeroRepositoryClass` / `HeroRepositoryStruct` -  repositories that calls on `MarvelHeroesService`  or returns previously fetched data (or returns an error)
`MarvelHeroesViewModel` - ViewModel that ultimately calls to fetch data by referencing one of the above 3 Dependencies

## Approach
`ViewModel` contains three methods `fetch-` from `Service`, `RepoClass`, `RepoStruct`
Each dependency is declared within its respective method, and/or locally outside of the method within the `ViewModel`
Additionally, each `Repo` declares the `Service` Dependency within the `fetch` method as well as at a higher level outside of the method within the Repo

## Execution
By overriding each method with an expected `Error` and toggling the placement of declarations, we are able to isolate failures and arrive at a better understanding of optimal Dependency usage
Ultimately this will also give us insight into the inner mechanisms of Dependencies (pending further spelunking)

## Results
Overall `class` Repositories behaved most stably; and Dependency declarations outside of methods were more reliably overriden

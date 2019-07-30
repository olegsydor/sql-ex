This README.TXT file describes the contents of the recipes.zip file associated
with the Transact-SQL Cookbook. In recipes.zip, you will find two files for
each recipe in the book:

        * A script to generate objects and sample data required
          to execute the recipe's solution code.

        * A script file containing the actual solution code.

The naming convention we use for the files is as follows:

        ChXX.Recipe Name.objects.sql - script to create objects needed
                                       by the recipe solution

        ChXX.Recipe Name.code.sql - script containing the code for
                                    the recipe solution

It may seem odd to have so many files, but we organized things this way to
make it easy for you to pick any recipe at random from the book and experiment
with it. For example, to try out Chapter 2's solution for comparing two tables
for equality, you would do the following:

        1. Execute Ch02.Comparing Two Sets for Equality.objects.sql in
           order to create the neccessary objects and sample data.

        2. Open Ch02.Comparing Two Sets for Equality.code.sql using any text
           editor (Notepad, Multi-Edit, SlickEdit, etc.).

        3. Code files often have more than one snippet of code. For example,
           we may show more than one variation of a solution. Copy and Paste
           the snippet of code that you wish to execute into your SQL Server
           Query Analyzer window. Then execute that code.

If you have questions about any of the recipes, or have trouble executing any
recipe code, please feel free to contact one of the authors:

        Ales Spetic - ales.spetic@siol.net

        Jonathan Gennick - Jonathan@Gennick.com

You may also send questions to bookquestions@oreilly.com.



/*
This file contains the 'Company' class. This class is used to store information about Acme corporation departments and employees.
*/

using System.Collections.Generic;
using System;

namespace PayrollLibrary
{

    public class Company
    {
        private string name;
        private CompanyAddress address;
        private string phoneNumber;
        private List<Department> departments;

        public Company(string name, CompanyAddress address, string phoneNumber)
        {
            this.name = name;
            this.address = address;
            this.phoneNumber = phoneNumber;
            departments = new List<Department>();
        }
        public List<Department> Departments => departments;

        /// <summary>
        /// Adds a department to the company.
        /// </summary>
        /// <remarks>
        /// This method adds a department to the company's list of departments.
        /// </remarks>
        /// <param name="department">The department to add.</param>
       
        public void AddDepartment(Department department)
        {
            departments.Add(department);
        }

        /// <summary>
        /// Retrieves the department with the specified ID.
        /// </summary>
        /// <remarks>
        /// This method searches the company's departments for a department with the specified ID.
        /// </remarks>
        /// <param name="id">The ID of the department to retrieve.</param>
        /// <returns>The department with the specified ID, or null if not found.</returns>
        public Department? GetDepartment(int id)
        {
            foreach (Department department in departments)
            {
                if (department.Id == id)
                {
                    return department;
                }
            }
            return null;
        }

    }


    public class CompanyAddress
    {
        private string address;
        private string city;
        private string state;
        private string zip;

        public CompanyAddress(string address, string city, string state, string zip)
        {
            this.address = address;
            this.city = city;
            this.state = state;
            this.zip = zip;
        }

        public string GetFullAddress()
        {
            return address + ", " + city + ", " + state + " " + zip;
        }
    }
}
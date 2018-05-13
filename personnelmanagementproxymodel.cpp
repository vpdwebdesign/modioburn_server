#include <QSqlQuery>
#include <QDebug>

#include "personnelmanagementproxymodel.h"
#include "personnelmanagementmodel.h"

PersonnelManagementProxyModel::PersonnelManagementProxyModel(QObject *parent)
    : QObject(parent)
{
    initCustomersModel();
    initAttendantsModel();
    initManagersModel();
    initAdminsModel();
}

QSortFilterProxyModel *PersonnelManagementProxyModel::customersModel() const
{
    return m_customersModel;
}

QSortFilterProxyModel *PersonnelManagementProxyModel::attendantsModel() const
{
    return m_attendantsModel;
}

QSortFilterProxyModel *PersonnelManagementProxyModel::managersModel() const
{
    return m_managersModel;
}

QSortFilterProxyModel *PersonnelManagementProxyModel::adminsModel() const
{
    return m_adminsModel;
}

//to_char(u.deregistered_date, 'DD Month YYYY, HH:MI:SS PM')

void PersonnelManagementProxyModel::initCustomersModel()
{
    PersonnelManagementModel *customersModel = new PersonnelManagementModel(this);
    QSortFilterProxyModel *customersProxyModel = new QSortFilterProxyModel(this);
    QSqlQuery q("SELECT u.name, u.gender, u.phone, u.email, uc.username, "
                "to_char(u.registered_date, 'DD Month YYYY, HH:MI:SS PM') as registered_date, "
                "to_char(u.suspended_date, 'DD Month YYYY, HH:MI:SS PM') as suspended_date, "
                "to_char(u.deregistered_date, 'DD Month YYYY, HH:MI:SS PM') as deregistered_date, "
                "u.status FROM users u, user_credentials uc WHERE u.id = uc.id AND u.id IN "
                "(SELECT DISTINCT user_id FROM user_roles WHERE role_id IN "
                "(SELECT DISTINCT id FROM roles WHERE role = 'customer'))");
    customersModel->setQuery(q);
    customersModel->generateRoleNames();

    customersProxyModel->setSourceModel(customersModel);

    m_customersModel = customersProxyModel;
}

void PersonnelManagementProxyModel::initAttendantsModel()
{
    PersonnelManagementModel *attendantsModel = new PersonnelManagementModel(this);
    QSortFilterProxyModel *attendantsProxyModel = new QSortFilterProxyModel(this);
    QSqlQuery q("SELECT u.name, u.gender, u.phone, u.email, uc.username, "
                "to_char(u.registered_date, 'DD Mon YYYY, HH:MI:SS PM') as registered_date, "
                "to_char(u.suspended_date, 'DD Mon YYYY, HH:MI:SS PM') as suspended_date, "
                "to_char(u.deregistered_date, 'DD Mon YYYY, HH:MI:SS PM') as deregistered_date, "
                "u.status FROM users u, user_credentials uc WHERE u.id = uc.id AND u.id IN "
                "(SELECT DISTINCT user_id FROM user_roles WHERE role_id IN "
                "(SELECT DISTINCT id FROM roles WHERE role = 'attendant'))");
    attendantsModel->setQuery(q);
    attendantsModel->generateRoleNames();

    attendantsProxyModel->setSourceModel(attendantsModel);

    m_attendantsModel = attendantsProxyModel;
}

void PersonnelManagementProxyModel::initManagersModel()
{
    PersonnelManagementModel *managersModel = new PersonnelManagementModel(this);
    QSortFilterProxyModel *managersProxyModel = new QSortFilterProxyModel(this);
    QSqlQuery q("SELECT u.name, u.gender, u.phone, u.email, uc.username, "
                "to_char(u.registered_date, 'DD Mon YYYY, HH:MI:SS PM') as registered_date, "
                "to_char(u.suspended_date, 'DD Mon YYYY, HH:MI:SS PM') as suspended_date, "
                "to_char(u.deregistered_date, 'DD Mon YYYY, HH:MI:SS PM') as deregistered_date, "
                "u.status FROM users u, user_credentials uc WHERE u.id = uc.id AND u.id IN "
                "(SELECT DISTINCT user_id FROM user_roles WHERE role_id IN "
                "(SELECT DISTINCT id FROM roles WHERE role = 'manager'))");
    managersModel->setQuery(q);
    managersModel->generateRoleNames();

    managersProxyModel->setSourceModel(managersModel);

    m_managersModel = managersProxyModel;
}

void PersonnelManagementProxyModel::initAdminsModel()
{
    PersonnelManagementModel *adminsModel = new PersonnelManagementModel(this);
    QSortFilterProxyModel *adminsProxyModel = new QSortFilterProxyModel(this);
    QSqlQuery q("SELECT u.name, u.gender, u.phone, u.email, uc.username, "
                "to_char(u.registered_date, 'DD Mon YYYY, HH:MI:SS PM') as registered_date, "
                "to_char(u.suspended_date, 'DD Mon YYYY, HH:MI:SS PM') as suspended_date, "
                "to_char(u.deregistered_date, 'DD Mon YYYY, HH:MI:SS PM') as deregistered_date, "
                "u.status FROM users u, user_credentials uc WHERE u.id = uc.id AND u.id IN "
                "(SELECT DISTINCT user_id FROM user_roles WHERE role_id IN "
                "(SELECT DISTINCT id FROM roles WHERE role = 'administrator'))");
    adminsModel->setQuery(q);
    adminsModel->generateRoleNames();

    adminsProxyModel->setSourceModel(adminsModel);

    m_adminsModel = adminsProxyModel;
}

void PersonnelManagementProxyModel::filter(const PersonnelManagementProxyModel::ModelType &modelType, const QString &filter)
{
    QSortFilterProxyModel *model = new QSortFilterProxyModel(this);
    int filterColumn = -1;

    switch (modelType) {
    case Customer:
        model = m_customersModel;
        break;
    case Attendant:
        model = m_attendantsModel;
        break;
    case Manager:
        model = m_managersModel;
        break;
    case Admin:
        model = m_adminsModel;
        break;
    }

    // Filter test
    QRegExp regExp(filter, Qt::CaseInsensitive, QRegExp::FixedString);

    model->setFilterRegExp(regExp);
    model->setFilterKeyColumn(filterColumn);
    qDebug() << "Filter Called: filter string =" << filter;
}

void PersonnelManagementProxyModel::sort(const PersonnelManagementProxyModel::ModelType &modelType, const int col, const Qt::SortOrder sortOrder)
{
    QSortFilterProxyModel *model = new QSortFilterProxyModel(this);

    switch (modelType) {
    case Customer:
        model = m_customersModel;
        break;
    case Attendant:
        model = m_attendantsModel;
        break;
    case Manager:
        model = m_managersModel;
        break;
    case Admin:
        model = m_adminsModel;
        break;
    }

    // Sort Test
    model->setSortCaseSensitivity(Qt::CaseInsensitive);
    model->sort(col, sortOrder);
    qDebug() << "Sort Called: sort column =" << col;
}

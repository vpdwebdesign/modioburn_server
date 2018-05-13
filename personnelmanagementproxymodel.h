#ifndef PERSONNELMANAGEMENTPROXYMODEL_H
#define PERSONNELMANAGEMENTPROXYMODEL_H

#include <QObject>

#include <QSortFilterProxyModel>

class PersonnelManagementProxyModel : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QSortFilterProxyModel *customersModel READ customersModel NOTIFY customersModelChanged)
    Q_PROPERTY(QSortFilterProxyModel *attendantsModel READ attendantsModel NOTIFY attendantsModelChanged)
    Q_PROPERTY(QSortFilterProxyModel *managersModel READ managersModel NOTIFY managersModelChanged)
    Q_PROPERTY(QSortFilterProxyModel *adminsModel READ adminsModel NOTIFY adminsModelChanged)

public:
    explicit PersonnelManagementProxyModel(QObject *parent = nullptr);

    enum ModelType {
        Customer,
        Attendant,
        Manager,
        Admin
    };
    Q_ENUMS(ModelType)

    QSortFilterProxyModel *customersModel() const;
    QSortFilterProxyModel *attendantsModel() const;
    QSortFilterProxyModel *managersModel() const;
    QSortFilterProxyModel *adminsModel() const;

public slots:
    void initCustomersModel();
    void initAttendantsModel();
    void initManagersModel();
    void initAdminsModel();

    void filter(const ModelType &modelType, const QString &filter = QString());
    void sort(const ModelType &modelType,const int col, const Qt::SortOrder sortOrder = Qt::AscendingOrder);

signals:
    void customersModelChanged();
    void attendantsModelChanged();
    void managersModelChanged();
    void adminsModelChanged();

private:
    QSortFilterProxyModel *m_customersModel;
    QSortFilterProxyModel *m_attendantsModel;
    QSortFilterProxyModel *m_managersModel;
    QSortFilterProxyModel *m_adminsModel;
};

#endif // PERSONNELMANAGEMENTPROXYMODEL_H
